#########################################################################
# Makefile for MJPA2.jar and MJ.jar, the MeggyJava compiler
#
#   make source, generates the source files for the lexer and parser
#                with JLex and JavaCUP
#
#   make, creates the MJPA2.jar scanner and MJ.jar compiler
#
#   make clean, removes all .class files and the source files generated by
#               JLex and JavaCUP
#
# The dependencies are not set up properly in this Makefile.  If you want
# to remake the jar file due to a change, then do a make clean first.
#
# Adapted from (WB)
# Michelle Strout, January 2011
# Ryan Moore, Fall 2010
# Michelle Strout, 2009
#########################################################################

# We need classes from the JavaCUP runtime library.
# This variable indicates where the java_cup/ subdirectory is located.

# created mj.cup to be bogus, only needed for token defs WB, June 2011

JAVA_CUP_RUNTIME = $(shell pwd)

SRC_DIR = src
PARSE_DIR = $(SRC_DIR)/mjparser
SCANNER = MJPA2
PROG = MJ

.SUFFIXES: .java.class

#-------------------------
JCC = javac
JAR = jar
#-------------------------

all: $(SCANNER).jar $(PROG).jar

source: $(PARSE_DIR)/Yylex.java $(PARSE_DIR)/mj.java

.PHONY:clean
clean:
	rm -rf $(SRC_DIR)/*.class $(SRC_DIR)/*/*.class
	rm -f $(PARSE_DIR)/sym.java $(PARSE_DIR)/mj.java $(PARSE_DIR)/Yylex.java
	rm -rf META_INF
	rm -rf $(PROG).jar
	rm -rf $(SCANNER).jar
	rm -rf javacup.dump

### Final jar files
$(SCANNER).jar: $(SRC_DIR)/$(SCANNER)Driver.class
	cd $(SRC_DIR); $(JAR) cmf $(SCANNER)MainClass.txt $(SCANNER).jar *.class */*.class */*/*.class -C $(JAVA_CUP_RUNTIME) java_cup  
	cd ..
	mv $(SRC_DIR)/$(SCANNER).jar .

$(PROG).jar: $(SRC_DIR)/$(PROG)Driver.class
	cd $(SRC_DIR); $(JAR) cmf $(PROG)MainClass.txt $(PROG).jar *.class */*.class */*/*.class avrH.rtl.s avrF.rtl.s -C $(JAVA_CUP_RUNTIME) java_cup  
	cd ..
	mv $(SRC_DIR)/$(PROG).jar .

#### mj parser
$(PARSE_DIR)/mj.java: $(PARSE_DIR)/mj.cup
	java -jar java-cup-11a.jar -parser  mj -dump $(PARSE_DIR)/mj.cup >& javacup.dump
	mv -f sym.java $(PARSE_DIR)/
	mv -f mj.java $(PARSE_DIR)/

#### lexer
$(PARSE_DIR)/Yylex.java: $(PARSE_DIR)/mj.lex $(PARSE_DIR)/mj.java 
	java -jar JLex.jar $(PARSE_DIR)/mj.lex
	mv $(PARSE_DIR)/mj.lex.java $(PARSE_DIR)/Yylex.java

#### Compile the Main class.
MAINSCANNER_DEPS = $(SRC_DIR)/$(SCANNER)Driver.java  \
            $(PARSE_DIR)/Yylex.java $(PARSE_DIR)/mj.java

$(SRC_DIR)/$(SCANNER)Driver.class: $(MAINSCANNER_DEPS)
	$(JCC) -classpath $(JAVA_CUP_RUNTIME):$(SRC_DIR) $(SRC_DIR)/$(SCANNER)Driver.java

MAINPROG_DEPS = $(SRC_DIR)/$(PROG)Driver.java  \
            $(PARSE_DIR)/Yylex.java $(PARSE_DIR)/mj.java

$(SRC_DIR)/$(PROG)Driver.class: $(MAINPROG_DEPS)
	$(JCC) -classpath $(JAVA_CUP_RUNTIME):$(SRC_DIR) $(SRC_DIR)/$(PROG)Driver.java

