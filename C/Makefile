# **************************************************************************** #
#                                   PROGRAM                                    #
# **************************************************************************** #

NAME = Colleen Grace Sully

# **************************************************************************** #
#                                     VARS                                     #
# **************************************************************************** #

UNAME_S := $(shell uname -s)

MKDIR = mkdir -p
RM = rm -rf

# **************************************************************************** #
#                                   COMPILER                                   #
# **************************************************************************** #

CC = gcc
CPPFLAGS = -MMD
CFLAGS = -Wall -Wextra -Werror

# **************************************************************************** #
#                                     DIRS                                     #
# **************************************************************************** #

OBJ_DIR = build

# **************************************************************************** #
#                                   SOURCES                                    #
# **************************************************************************** #

SRC = $(NAME:%=%.c)

OBJ = $(NAME:%=$(OBJ_DIR)/%.o)
DEP = $(OBJ:%.o=%.d)

# files written by Grace and Sully at runtime
GEN = Grace_kid.c Sully_*

# **************************************************************************** #
#                                    RULES                                     #
# **************************************************************************** #

PHONY := all
all: $(NAME)

$(NAME): %: $(OBJ_DIR)/%.o
	$(CC) $(CFLAGS) -o $@ $<

PHONY += sanitize
ifeq ($(UNAME_S),Linux)
sanitize:: CFLAGS += -g3 -fsanitize=address -fsanitize=leak -fsanitize=undefined -fsanitize=bounds -fsanitize=null
endif
ifeq ($(UNAME_S),Darwin)
sanitize:: CFLAGS += -g3 -fsanitize=address
endif
sanitize:: $(NAME)

$(OBJ_DIR)/%.o: %.c | $(OBJ_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(OBJ_DIR):
	$(MKDIR) $(OBJ_DIR)

PHONY += clean
clean:
	$(RM) $(OBJ_DIR)

PHONY += fclean
fclean: clean
	$(RM) $(NAME) $(GEN)

PHONY += re
re:: fclean
re:: all

-include $(DEP)

.PHONY: $(PHONY)
