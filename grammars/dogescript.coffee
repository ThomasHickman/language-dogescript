{makeGrammar, rule} = require('atom-syntax-tools')

grammar =
    name: "dogescript"
    scopeName: "source.dogescript"
    fileTypes: [ "djs" ]
    firstLineMatch: '^#!.*\\bdogescript'

    macros:
        id: /(?:[a-zA-Z$_][a-zA-Z$_\d]*)/
        whsp: /(?: |\t)+/

    patterns: [
        {
            name: "comment.line"
            begin: "shh"
            end: /\n/
        }
        {
            name: "comment.block"
            begin: /^quiet/
            end: /^loud/
        }
        {
            name: 'string.quoted.single'
            begin: /\'/
            captures:
                0:
                    name: 'punctuation.definition.string.begin'
            end: '\''
            endCaptures:
                0:
                    name: 'punctuation.definition.string.end'
            patterns: [
                {
                    match: /\\(x\h{2}|[0-2][0-7]{0,2}|3[0-6][0-7]?|37[0-7]?|[4-7][0-7]?|.)/
                    name: 'constant.character.escape'
                }
                {
                    match: /[^']*[^\n\\r'\\]$/
                    name: 'invalid.illegal.string'
                }
            ]
        }
        {
            name: "storage.type.var"
            match: /\bvery\b/
        }
        {
            name: "keyword.operator.assignment"
            match: /\bis\b/
        }
        {
            name: "meta.function"
            match: /(such){whsp}({id})(?:{whsp}(much){whsp}(.*))?/
            captures:
                1:
                    name: "storage.type.function"
                2:
                    name: "entity.name.function"
                3:
                    name: "storage.type.function"
                4:
                    name: "meta.function.parameters"
                    patterns:
                        [{
                            name: "variable.parameter.function"
                            match: /{id}/
                        }]
            }
            {
                name: "meta.function-call"
                match: /(plz){whsp}({id}(?:\.{id})*)(?:{whsp}(with){whsp}(.*))?/
                captures:
                    1:
                        name: "keyword.control"
                    2:
                        patterns: [
                            {
                                match: /^{id}$/
                                name: "entity.name.function"
                            }
                            {
                                match: /^({id}\.)+({id})$/
                                captures:
                                    1:
                                        patterns: [
                                            match: /{id}/
                                            name: "variable.other.object"
                                        ]
                                    2:
                                        name: "entity.name.function"
                            }
                        ]
                    3:
                        name: "keyword.control"
                    4:
                        name: "meta.function.parameters"
                        patterns: [
                            include: "source.dogescript"
                        ]
                }
            {
                name: "keyword.control"
                match: /\b(?:wow|wow&|rly|but|maybe|notrly|many|many|so|as|does|trained)\b/
            }
            {
                name: "constant.numeric.decimal"
                match: /\d+(?:\.\d+)?(?:e(?:\+|-)\d+)?/
            }
            {
                name: "keyword.operator"
                match: /[+\-*/%^!?:&|]/
            }
        ]

makeGrammar grammar, "CSON"
