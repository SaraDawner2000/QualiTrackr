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
2. Quality project must have customer - database - model
3. Quality project must have a purchase order before an inspection plan can be made ???
4. Quality project associated part (and children, if any) must have a drawing attached before an inspection plan can be made ???
5. Quality project must have an inspection plan attached before it can be approved
6. Quality project associated part (and children, if any) before the report can be approved
7. Quality project must have an approved report before a record can be assembled
8. if customer == "mctractor":
  - Quality project must have a customer request before a record can be assembled
9. Quality project must have an assembled record attached before it can be marked approved
10. Quality project customer approval should automatically change to "ready" once an assembled record is approved





!!!!!! BUG BUG BUG BUG !!!!!!!!