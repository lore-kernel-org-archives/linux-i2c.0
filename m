From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/6] i2c-parport: define ports to connect
Date: Wed, 20 May 2015 20:56:59 +0530
Message-ID: <1432135622-8288-4-git-send-email-sudipm.mukherjee@gmail.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Tim Waugh <tim@cyberelk.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

As of now i2c-parport was connecting to all the available parallel
ports. Lets limit that to maximum of 4 instances and at the same time
define which instance connects to which parallel port.

Tested-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

MODULE_PARM_DESC modified

 drivers/i2c/busses/i2c-parport.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index a1fac5a..155da95 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -46,6 +46,9 @@ struct i2c_par {
 
 static LIST_HEAD(adapter_list);
 static DEFINE_MUTEX(adapter_list_lock);
+#define MAX_DEVICE 4
+static int parport[MAX_DEVICE] = {0, -1, -1, -1};
+
 
 /* ----- Low-level parallel port access ----------------------------------- */
 
@@ -163,6 +166,19 @@ static void i2c_parport_irq(void *data)
 static void i2c_parport_attach(struct parport *port)
 {
 	struct i2c_par *adapter;
+	int i;
+	struct pardev_cb i2c_parport_cb;
+
+	for (i = 0; i < MAX_DEVICE; i++) {
+		if (parport[i] == -1)
+			continue;
+		if (port->number == parport[i])
+			break;
+	}
+	if (i == MAX_DEVICE) {
+		pr_debug("i2c-parport: Not using parport%d.\n", port->number);
+		return;
+	}
 
 	adapter = kzalloc(sizeof(struct i2c_par), GFP_KERNEL);
 	if (adapter == NULL) {
@@ -298,5 +314,12 @@ MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
 MODULE_DESCRIPTION("I2C bus over parallel port");
 MODULE_LICENSE("GPL");
 
+module_param_array(parport, int, NULL, 0);
+MODULE_PARM_DESC(parport,
+		 "List of parallel ports to bind to, by index.\n"
+		 " Atmost " __stringify(MAX_DEVICE) " devices are supported.\n"
+		 " Default is one device connected to parport0.\n"
+);
+
 module_init(i2c_parport_init);
 module_exit(i2c_parport_exit);
-- 
1.8.1.2
