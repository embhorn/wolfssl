###############################################################################
# (C) -----
# -----
# All rights reserved.
#
# Purpose:
#  ----
#
# $Id: --- $
# $Author: --- $
# $Date: --- $
# $Revision: --- $
###############################################################################

ifneq ($(MAKEINC_OPTION_POSIX_WOLFSSL_MK),included)
MAKEINC_OPTION_POSIX_WOLFSSL_MK := included

ifeq ($(POSIX_WOLFSSL), true)

# Add personality option identifier
	CPPFLAGS += -DPOSIX_WOLFSSL

# If $(POSIX_WOLFSSL_CUSTOM) is set, we do not refer to lwIP bits
# from the custom pool. This is for compatibility with older
# versions and will be removed in future versions.
ifeq ($(POSIX_WOLFSSL_CUSTOM), true)
# If unset in the configuration, default custom lwIP files to current directory
	POSIX_WOLFSSL_LIB_DIR ?= .
# Add lwIP custom configuration header
	CPPFLAGS += -I$(POSIX_WOLFSSL_LIB_DIR)
# Add lwIP custom library path
	LDFLAGS += -L$(POSIX_WOLFSSL_LIB_DIR)

$(eval $(call declare_variable,POSIX_WOLFSSL_LIB_DIR,Path to the customized lwIP library))

else
# Add lwIP standard configuration header
	CPPFLAGS += -I$(CUSTOM_POOL_DIR)/posix/wolfssl/include/opts
	CPPFLAGS += -I$(PIKEOS_POOL_DIR)/posix/wolfssl/include/opts
# Add lwIP library path
	LDFLAGS += -L$(CUSTOM_POOL_DIR)/posix/wolfssl/lib
	LDFLAGS += -L$(PIKEOS_POOL_DIR)/posix/wolfssl/lib

# Add lwIP headers
	CPPFLAGS += -I$(CUSTOM_POOL_DIR)/posix/wolfssl/include
endif

# Add lwIP headers
	CPPFLAGS += -I$(PIKEOS_POOL_DIR)/posix/wolfssl/include

# Add lwIP library
	LDLIBS += -lwolfcrypt

# Add SBUF library
	LDLIBS += -lsbuf
endif

endif
