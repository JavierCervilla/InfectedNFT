//SPDX-License-Identifier: GPL-3.0

/*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWNNXXXXKKKKKKKKKKKKXXXNNNWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMMMMMMMMMMMMWNK0kdolc:;,,'''.............'''',;;:clodk0KNWMMMMMMMMMMMMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMMMMMMMWN0xo:,...                                    ...,:lx0XWMMMMMMMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMMMMWKxc,..                                                ..'cd0NMMMMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMWKx:..                                                        ..;o0NMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMW0l'.                                                              ..:kXMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMW0c..                                                                   .;xNMMMMMMMMMMM*/
/*MMMMMMMMMMMMXo.                                       ,:.                              .:OWMMMMMMMMM*/
/*MMMMMMMMMMWO;.                                      .,ONx'                               .oXMMMMMMMM*/
/*MMMMMMMMMNd.                                     ..'lKWMWOc.                              .cKMMMMMMM*/
/*MMMMMMMMNo.                                    .:dOKWMMMMMW0o;.                            .;0MMMMMM*/
/*MMMMMMMNo.                                     .ck0XMMMMMMWKx:.                             .;0MMMMM*/
/*MMMMMMWd.                                      . ..,dXMMMKo'.                                .cXMMMM*/
/*MMMMMWk'                                     .,l;.  .:KWO,.                                   .dNMMM*/
/*MMMMMX:.                                   .'oKWXdc,..;o'                                      ,OMMM*/
/*MMMMWx.                                    ..c0WKl;'. ..                                       .lNMM*/
/*MMMMX:.                                       'c,.                                              ,0MM*/
/*MMMMO'                                                                                          .xWM*/
/*MMMWd.                                                                                          .lNM*/
/*MMMNc.                       .:dddddddddddddddo:.            .cdddddl'.                          :XM*/
/*MMMK;                        .lXMMMMMMMMMMMMMMXc.            .:0MMMXl.                           ;KM*/
/*MMM0,                         .xWMMMMMMMMMMMMWx.              .;KMNl.                            ,0M*/
/*MMM0,                         .lNMMMMMMMMMMMMNl.               .oNk.                             'OM*/
/*MMMO'                         .cNMMMMMMMMMMMMXc.                cKo.                             'OM*/
/*MMMO'                         .cNMMMMMMMMMMMMXc.                :Ko.                             'kM*/
/*MMMO,                         .cNMMMMMMMMMMMMXc                 :Ko.                             .kM*/
/*MMM0,                         .cNMMMMMMMMMMMMXc.                :Ko.                             'kM*/
/*MMMK:                         .cNMMMMMMMMMMMMXc.                :Ko.                             'OM*/
/*MMMNl.                        .cNMMMMMMMMMMMMXc.                :Ko.                             ,0M*/
/*MMMWd.                        .cNMMMMMMMMMMMMXc.                :Ko.                             :XM*/
/*MMMM0,                        .cNMMMMMMMMMMMMXc.                :Ko.                            .lNM*/
/*MMMMNl.                       .cNMMMMMMMMMMMMXc                 :Ko.                            .xMM*/
/*MMMMMO,                       .cXMMMMMMMMMMMMNc.               .cKl.                            ;KMM*/
/*MMMMMNo.                       ;0MMMMMMMMMMMMWo.               .d0;                            .dWMM*/
/*MMMMMMXc.                      .dNMMMMMMMMMMMMO,               ;0x.                           .:KMMM*/
/*MMMMMMM0;.                      .xNMMMMMMMMMMMWx'            .;Ok,                            ,OWMMM*/
/*MMMMMMMM0:.                      .c0NMMMMMMMMMMW0l;,..   ...;dOd'                            'xWMMMM*/
/*MMMMMMMMMKc.                       .:dOKNWWMMMMMMWNX0kdddddxxl,.                            'xWMMMMM*/
/*MMMMMMMMMMNd'.                        ..,;:ccccccccccccc:;,..                             .;OWMMMMMM*/
/*MMMMMMMMMMMW0c.                                                                          .lKMMMMMMMM*/
/*MMMMMMMMMMMMMNk:.                                                                      .:ONMMMMMMMMM*/
/*MMMMMMMMMMMMMMMNOc'.                                                                 .:kNMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMWKx:'.                                                          ..;o0WMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMMMMWKko;'..                                                 ..':d0NMMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMMMMMMMMWXOxoc;'...                                   ...',:ox0XWMMMMMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNXKOkxdollcc:::;;;;;;;;;;;;;;;;;::ccloodkO0XNWMMMMMMMMMMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWWWWWWWWWWNNNWWWWWWWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM*/
/*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM*/

pragma solidity ^0.8.0;

//import "openzeppelin-contracts-upgradeable/contracts/utils/cryptography/MerkleProofUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/cryptography/MerkleProofUpgradeable.sol";
//import "openzeppelin-contracts-upgradeable/contracts/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "./interfaces/IERC2981.sol";

contract InfectedNFT is
    ERC1155Upgradeable,
    IERC2981 /*TODO: 1155D*/
{
    address public admin;

    uint256 public id;

    bool public paused;

    uint256 public maxNFTPublic = 2;

    uint256 public constant zeroPatientSupply = 100;

    uint256 public constant publicPrice = 0.01 ether;

    string public contractUri;

    event InfectedMint(uint256 infectedNFT, uint256 infectedBy);

    function initialize(string memory _metadata, string memory _contractURI)
        public
        virtual
        initializer
    {
        admin = msg.sender;
        id = 1;
        paused = true;
        contractUri = _contractURI;
        __ERC1155_init(_metadata);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155Upgradeable, IERC2981)
        returns (bool)
    {
        return (ERC1155Upgradeable.supportsInterface(interfaceId) ||
            interfaceId == type(IERC2981).interfaceId);
    }

    function royaltyInfo(uint256 tokenId, uint256 _salePrice)
        external
        view
        virtual
        override
        returns (address _receiver, uint256 _royaltyAmount)
    {
        require(tokenId < id, "Error: invalid token id");
        return (owner(), (_salePrice * 1) / 100);
    }

    function mint(uint256 _amount) public payable {
        require(paused == false, "Error: public mint is paused");
        require(id <= zeroPatientSupply, "Error: max supply reached");
        require(
            _amount <= maxNFTPublic && _amount > 0,
            "Error: you can't mint more than max public supply and less than one"
        );
        require(
            (id + _amount) <= zeroPatientSupply,
            "Error: more than max supply will be reached"
        );
        require(
            msg.value >= publicPrice * _amount,
            "Error: insufficient funds"
        );
        for (uint256 i = 0; i < _amount; i++) {
            unchecked {
                id++;
            }
            _mint(msg.sender, (id - 1), 1, "");
        }
    }

    function _infectedMint(uint256 _currentPatient) internal {
        require(paused == false, "Error: contract is paused");
        unchecked {
            id++;
        }
        uint256 _tokenId = zeroPatientSupply + _currentPatient + (id - 1);
        _mint(msg.sender, _tokenId, 1, "");
        emit InfectedMint(_tokenId, _currentPatient);
    }

    function _beforeTokenTransfer(
        address /* operator */,
        address from,
        address /* to */,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory /* data */
    ) internal virtual override {
        require(paused == false, "Error: contract is paused");
        require(
            ids.length == amounts.length,
            "Error: ids and amounts must have the same length"
        );
        if (from != address(0)) {
            for (uint256 i = 0; i < ids.length; i++) {
                _infectedMint(ids[i]);
            }
        }
    }

    function setAdmin(address _admin) public virtual onlyAdmin {
        require(admin != _admin, "Error: admin already setted");
        admin = _admin;
    }

    function setPaused(bool _paused) public virtual onlyAdmin {
        require(paused != _paused, "Error: public mint already paused");
        paused = _paused;
    }

    function owner() public view virtual returns (address) {
        return admin;
    }

    function contractURI() public view virtual returns (string memory) {
        /**TODO: setter?? */
        return (contractUri);
    }

    receive() external payable {
        /**TODO: splitter? */
    }

    function sendValueCall(address payable recipient, uint256 amount)
        public
        virtual
        onlyAdmin
    {
        AddressUpgradeable.sendValue(recipient, amount);
    }

    modifier onlyAdmin() {
        require(
            msg.sender == admin,
            "Error: only admin can call this function"
        );
        _;
    }
}
