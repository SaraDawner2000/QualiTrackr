# Restrictions
## Part
1. part must have number and revision - database - model
2. part must drawing before it can have an inspection plan ???
3. part must have job number before it can be measured ???
4. part must have material specified before it can be measured ???
5. if part material == "subcomponent":
  1. part must have at least one child part specified ???
  2. all child parts must have job numbers specified before they can be measured ???
  3. all child parts must have base material specified before they can be measured ???
  4. all child parts must be measured before the parent part can be measured ???
6. After this, part can be measured

## Quality project
1. Quality project must be associated with a part - model
2. Quality project must have customer

!!!!!! BUG BUG BUG BUG !!!!!!!!