from ants import *
beehive, layout = Hive(AssaultPlan()), dry_layout
gamestate = GameState(beehive, ant_types(), layout, (1, 9))
container = ContainerAnt(1)
other_ant = ThrowerAnt()
place = gamestate.places['tunnel_0_0']
place.add_insect(container)  # ContainerAnt in place first
place.add_insect(other_ant)