
//java -jar antlr-4.9.2-complete.jar c.g4
//javac -cp .:antlr-4.9.2-complete.jar *.java
//java -cp .:antlr-4.9.2-complete.jar cParserApp

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import java.nio.file.Files;
import java.io.File;

public class cParserApp {

    public static void main(String[] args) {

        // ==========================
        // Verificação de argumentos
        // ==========================
        if (args.length == 0) {
            System.out.println("Uso: java cParserApp <ficheiro.c>");
            return;
        }

        try {
            // ==========================
            // Ler ficheiro inteiro
            // ==========================
            File file = new File(args[0]);

            if (!file.exists()) {
                System.out.println("Ficheiro não encontrado: " + args[0]);
                return;
            }

            String input = new String(Files.readAllBytes(file.toPath()));

            //System.out.println("=== SOURCE ===");
            //System.out.println(input);

            // ==========================
            // ANTLR Lexer + Parser
            // ==========================
            CharStream charStream = CharStreams.fromString(input);

            cLexer lexer = new cLexer(charStream);
            CommonTokenStream tokens = new CommonTokenStream(lexer);

            cParser parser = new cParser(tokens);

            // IMPORTANTE: regra correta da tua gramática
            ParseTree tree = parser.compilationUnit();

            // ==========================
            // Output árvore sintática
            // ==========================
            System.out.println("\n=== ÁRVORE SINTÁTICA ===");
            System.out.println(tree.toStringTree(parser));

            // ==========================
            // Tokens
            // ==========================
            System.out.println("\n=== TOKENS ===");
            tokens.fill();

            for (Token token : tokens.getTokens()) {
                String name = cLexer.VOCABULARY.getSymbolicName(token.getType());
                System.out.printf("Tipo: %s | Valor: %s%n", name, token.getText());
            }

        } catch (Exception e) {
            System.out.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }
}