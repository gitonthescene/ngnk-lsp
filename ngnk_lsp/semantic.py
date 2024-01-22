import kapi as k
import json


def init():
    """Load K interface to semantic parsing."""
    # import semantic.k
    k.Kx("\\l semantic.k", ())

    # load legend
    legend = k.CK(k.Kx("legend", ()))
    return json.loads(legend)


def get_semantic_tokens(doc):
    """Call k/api to extract semantic tokens."""
    args = (k.K * 1)()
    args[0] = k.KC(doc, len(doc))

    return k.IK(k.Kx("tkn", args))
