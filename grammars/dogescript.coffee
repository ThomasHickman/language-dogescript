{makeGrammar, rule} = require('atom-syntax-tools')

grammar =
    name: "dogescript"
    scopeName: "source.dogescript"
    fileTypes: [ "djs" ]
    firstLineMatch: '^#!.*\\bdogescript'

    macros:
        id: /[a-zA-Z$_][a-zA-Z$_\d]*/
        whsp: /(?: |\t)+/

    patterns: [
        {
            name: "comment.line.dogescript"
            begin: "ssh"
            end: /\n/
        }
        {
            name: 'string.quoted.single.dogescript'
            begin: /\'/
            captures:
                0:
                    name: 'punctuation.definition.string.begin.dogescript'
            end: '\''
            endCaptures:
                0:
                    name: 'punctuation.definition.string.end.dogescript'
            patterns: [
                {
                    match: /\\(x\h{2}|[0-2][0-7]{0,2}|3[0-6][0-7]?|37[0-7]?|[4-7][0-7]?|.)/
                    name: 'constant.character.escape.dogescript'
                }
                {
                    match: /[^']*[^\n\\r'\\]$/
                    name: 'invalid.illegal.string.dogescript'
                }
            ]
        }
        {
            name: "storage.type.var.dogescript"
            match: /\bvery\b/
        }
        {
            name: "keyword.operator.assignment.dogescript"
            match: /\bis\b/
        }
        {
            name: "meta.function.dogescript"
            match: /(such){whsp}({id})(?:{whsp}(much){whsp}(.*))?/
            captures:
                1:
                    name: "storage.type.function.dogescript"
                2:
                    name: "entity.name.function.dogescript"
                3:
                    name: "storage.type.function.dogescript"
                4:
                    name: "meta.function.parameters.dogescript"
                    patterns:
                        [{
                            name: "variable.parameter.function.dogescript"
                            match: /{id}/
                        }]
            }
        ]

makeGrammar grammar, "CSON"
