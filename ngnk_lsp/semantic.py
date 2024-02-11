import ngnk_lsp.kapi as k
import json
from   importlib import resources


def init():
    """Load K interface to semantic parsing."""
    # import semantic.k
    with resources.as_file(resources.files("ngnk_lsp").joinpath("semantic.k")) as semantick:
        k.Kx("\\l "+str(semantick), ())

    # load legend
    legend = k.CK(k.Kx("legend", ()))
    return json.loads(legend)


def get_semantic_tokens(doc):
    """Call k/api to extract semantic tokens."""
    args = (k.K * 1)()
    args[0] = k.KC(doc, len(doc))

    return k.IK(k.Kx("tkn", args))
