import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const GenericERC20Module = buildModule("GenericERC20Module", (m) => {
  const token = m.contract("GenericERC20", ["GenericERC20", "GT"]);

  return { token };
});

export default GenericERC20Module;
