module "virtual_machine" {
  source           = "./modules/vm"
  virtual_machines = local.machines
}
