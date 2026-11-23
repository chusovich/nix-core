let
  personal = "age12m9g35fxvuet8psscpewentq496vdmg02f0nkqtk7q8ql0uz9p9s9mwd5c";
  beszelServer = "age1y5l2tzcqp477ztnugq6wt0dl7guqlfw2psu22vel0gtk25mr8afs2n375q";
in
{
  "secrets/beszel-env.age".publicKeys = [ personal beszelServer ];
}
