From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] HID: mcp2221: mcp_smbus_xfer() can be static
Date: Tue, 21 Jan 2020 02:05:40 +0800
Message-ID: <20200120180540.5v5mzbr72aygwb6l@f53c9c00458a>
References: <7b81210829dabdc96257084ff5b4cc97f2f2ebec.1579497275.git.gupt21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7b81210829dabdc96257084ff5b4cc97f2f2ebec.1579497275.git.gupt21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@lists.01.org, jikos@kernel.org, benjamin.tissoires@redhat.com, wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
List-Id: linux-i2c@vger.kernel.org


Fixes: 38f8a303aca6 ("HID: mcp2221: add usb to i2c-smbus host bridge driver")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 hid-mcp2221.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 9897599a868bf..b0e7ea0d267d0 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -394,7 +394,7 @@ static int mcp_smbus_write(struct mcp2221 *mcp, u16 addr,
 	return ret;
 }
 
-int mcp_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
+static int mcp_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 				unsigned short flags, char read_write,
 				u8 command, int size,
 				union i2c_smbus_data *data)
