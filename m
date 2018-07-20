From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v4 2/2] i2c: mux: annotate the nested rt_mutex usage
Date: Fri, 20 Jul 2018 10:39:14 +0200
Message-ID: <20180720083914.1950-3-peda@axentia.se>
References: <20180720083914.1950-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720083914.1950-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Davidlohr Bueso <dave@stgolabs.net>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>, Deepa Dinamani <deepadinamani@google.com>, John Sperbeck <jsperbeck@google.com>
List-Id: linux-i2c@vger.kernel.org

If an i2c topology has instances of nested muxes, then a lockdep splat
is produced when when i2c_parent_lock_bus() is called.  Here is an
example:

============================================
WARNING: possible recursive locking detected
--------------------------------------------
insmod/68159 is trying to acquire lock:
  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]

but task is already holding lock:
  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(i2c_register_adapter#2);
   lock(i2c_register_adapter#2);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

1 lock held by insmod/68159:
  #0:  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]

stack backtrace:
CPU: 13 PID: 68159 Comm: insmod Tainted: G           O
Call Trace:
  dump_stack+0x67/0x98
  __lock_acquire+0x162e/0x1780
  lock_acquire+0xba/0x200
  rt_mutex_lock+0x44/0x60
  i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
  i2c_parent_lock_bus+0x3e/0x50 [i2c_mux]
  i2c_smbus_xfer+0xf0/0x700
  i2c_smbus_read_byte+0x42/0x70
  my2c_init+0xa2/0x1000 [my2c]
  do_one_initcall+0x51/0x192
  do_init_module+0x62/0x216
  load_module+0x20f9/0x2b50
  SYSC_init_module+0x19a/0x1c0
  SyS_init_module+0xe/0x10
  do_syscall_64+0x6c/0x1a0
  entry_SYSCALL_64_after_hwframe+0x42/0xb7

Reported-by: John Sperbeck <jsperbeck@google.com>
Tested-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 drivers/i2c/i2c-mux.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index f5ec6ec6776f..1157a64c7be3 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -615,7 +615,7 @@ static int i2c_check_addr_busy(struct i2c_adapter *adapter, int addr)
 static void i2c_adapter_lock_bus(struct i2c_adapter *adapter,
 				 unsigned int flags)
 {
-	rt_mutex_lock(&adapter->bus_lock);
+	rt_mutex_lock_nested(&adapter->bus_lock, i2c_adapter_depth(adapter));
 }
 
 /**
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 9669ca4937b8..7ba31f6bf148 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -144,7 +144,7 @@ static void i2c_mux_lock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	struct i2c_mux_priv *priv = adapter->algo_data;
 	struct i2c_adapter *parent = priv->muxc->parent;
 
-	rt_mutex_lock(&parent->mux_lock);
+	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
 	if (!(flags & I2C_LOCK_ROOT_ADAPTER))
 		return;
 	i2c_lock_bus(parent, flags);
@@ -181,7 +181,7 @@ static void i2c_parent_lock_bus(struct i2c_adapter *adapter,
 	struct i2c_mux_priv *priv = adapter->algo_data;
 	struct i2c_adapter *parent = priv->muxc->parent;
 
-	rt_mutex_lock(&parent->mux_lock);
+	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
 	i2c_lock_bus(parent, flags);
 }
 
-- 
2.11.0
