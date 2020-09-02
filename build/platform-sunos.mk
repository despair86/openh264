include $(SRC_PATH)build/arch.mk
SHAREDLIBSUFFIX = so
SHAREDLIBSUFFIXFULLVER=$(SHAREDLIBSUFFIX).$(FULL_VERSION)
SHAREDLIBSUFFIXMAJORVER=$(SHAREDLIBSUFFIX).$(SHAREDLIB_MAJORVERSION)
SHLDFLAGS = -Wl,-h,$(LIBPREFIX)$(PROJECT_NAME).$(SHAREDLIBSUFFIXMAJORVER)
CFLAGS += -Wall -fno-strict-aliasing -fPIC -MMD -MP -fpermissive
ifeq ($(USE_STACK_PROTECTOR), Yes)
CFLAGS += -fstack-protector-all
LDFLAGS += -fstack-protector-all
STATIC_LDFLAGS += -fstack-protector-all
SHLDFLAGS += -fstack-protector-all
endif
LDFLAGS += -lpthread
STATIC_LDFLAGS += -lpthread -lm
AR_OPTS = crD $@
ifeq ($(ASM_ARCH), x86)
ifeq ($(ARCH), x86_64)
ASMFLAGS += -f elf64
else
ASMFLAGS += -f elf
endif
endif
ifeq ($(ASM_ARCH), sparc)
ASMFLAGS += -march=sparcv8 -mvis
endif

ifeq ($(ASM_ARCH), sparcv9)
CFLAGS += -march=sparcv9
ASMFLAGS += -march=sparcv9
endif

ifeq ($(CXX), clang++)
CXXFLAGS += -Wc++11-compat-reserved-user-defined-literal
endif

