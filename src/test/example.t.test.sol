pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../contracts/Logic.sol";
import "../contracts/Proxy.sol";

interface CheatCodes {
    function expectRevert(bytes calldata) external;
    function prank(address) external;
    function startPrank(address) external;
    function stopPrank() external;
    function assume(bool) external;
    function deal(address,uint256) external;
}

contract Dtesting is DSTest {

    InfectedNFT logic;
    Proxy proxy;
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
    address public deployer = 0xF410D6069f76F3ccF035D397E28dF3E90A82885D;
    address public richard = 0x0b5326e492f20d713b6E0f4fef6B37774fBF61d4;

    constructor() {
        logic = new InfectedNFT();
        proxy = new Proxy(address(logic), "metadata goes here", "contract uri goes here");
        cheats.prank(deployer);
        logic.initialize("metadata goes here", "contract uri goes here");
    }

    /*
     * ProxyTests
     */
    function testProxy_setLogic_notAdmin(address _address) public {
        cheats.expectRevert(bytes("you're not the proxy admin"));
        cheats.prank(_address);
        proxy.setLogicContract(_address);
    }
    function testProxy_setAdmin_notAdmin(address _address) public {
        cheats.expectRevert(bytes("you're not the proxy admin"));
        cheats.prank(_address);
        proxy.setProxyAdmin(_address);
    }
    function testProxy_setLogic_admin(address _address) public {
        proxy.setLogicContract(_address);
        assertEq(proxy.implementation(), _address);
    }
    function testProxy_setAdmin_admin(address _address) public {
        proxy.setProxyAdmin(_address);
        assertEq(proxy.proxyAdmin(), _address);
    }
    /*
     * logicTests
     */
    function testLogic_initialize() public {
        assertEq(logic.owner(), deployer);
        assertEq(logic.uri(1), "metadata goes here");
        assertEq(logic.id(), 1);
        assertTrue(logic.paused());
        assertEq(logic.contractURI(), "contract uri goes here");
    }
    function testLogic_supportsInterface() public {
        bytes4  ID_2981 = type(IERC2981).interfaceId;
        bool check2981 = logic.supportsInterface(ID_2981);
        bool check1155 = logic.supportsInterface(0xd9b67a26);
        bool check1155Meta = logic.supportsInterface(0x0e89341c);
        assertTrue(check2981);
        assertTrue(check1155);
        assertTrue(check1155Meta);
    }

    function testLogic_mintPublic_paused(uint256 _amount) public {
        cheats.expectRevert(bytes("Error: public mint is paused"));
        logic.mint(_amount);
    }

    function testLogic_mintPublic_notPaused() public {
        cheats.prank(deployer);
        logic.setPaused(false);
        cheats.deal(richard, 1 ether);
        cheats.startPrank(richard);
        logic.mint{value:logic.publicPrice()}(1);
        assertEq(logic.balanceOf(richard, 1), 1, "not minted");
        cheats.stopPrank();
    }
}