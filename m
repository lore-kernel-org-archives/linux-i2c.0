From: Tobias Thomer <thomer.tobias@gmail.com>
Subject: Re: [PATCH v7] i2c: Add PCI and platform drivers for the AMD MP2 I2C controller
Date: Tue, 30 Oct 2018 22:47:20 +0100
Message-ID: <CAHYSBa-QNtqZ9f__ysG9cz33LiCEpjVBHrPvHhgPn2gzVUhv8Q@mail.gmail.com>
References: <20181027150910.GA2070@syn-yoga530> <20181030205624.GC13681@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181030205624.GC13681@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: helgaas@kernel.org
Cc: syniurge@gmail.com, linux-i2c@vger.kernel.org, wsa@the-dreams.de, Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com, sandeep.singh@amd.com, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

I've tested v7 on a Yoga 530 and it seems to work (sometimes for
hours) but it randomly dies with a i2c read timeout

[ 9562.237020] i2c_amd_plat_mp2 AMDI0011:00: i2c read timed out

and reloading/removing of the module results in this:

[ 9703.591021] pcie_mp2_amd 0000:03:00.7: length 0 in event doesn't
match buffer length 64!
[ 9703.591030] pcie_mp2_amd 0000:03:00.7: unexpected slave address 0
(expected: 2c)!
[ 9703.863740] i2c_amd_plat_mp2 AMDI0011:01: i2c connection timed out
[ 9707.596826] INFO: task irq/67-WCOM517E:340 blocked for more than 120 seconds.
[ 9707.596838]       Tainted: G           OE     4.19.0-v7 #1
[ 9707.596841] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 9707.596845] irq/67-WCOM517E D    0   340      2 0x80000080
[ 9707.596851] Call Trace:
[ 9707.596868]  ? __schedule+0x29b/0x8b0
[ 9707.596873]  schedule+0x32/0x90
[ 9707.596875]  schedule_preempt_disabled+0x14/0x20
[ 9707.596879]  __mutex_lock.isra.0+0x217/0x520
[ 9707.596884]  ? __switch_to_asm+0x40/0x70
[ 9707.596887]  ? __switch_to_asm+0x34/0x70
[ 9707.596890]  ? __switch_to_asm+0x34/0x70
[ 9707.596898]  amd_mp2_read+0x4f/0x17b [i2c_amd_pci_mp2]
[ 9707.596912]  i2c_amd_xfer+0x61/0x150 [i2c_amd_plat_mp2]
[ 9707.596919]  __i2c_transfer+0x142/0x480
[ 9707.596922]  ? _raw_spin_unlock_irq+0x1d/0x30
[ 9707.596926]  ? irq_forced_thread_fn+0x70/0x70
[ 9707.596929]  i2c_transfer+0x51/0xc0
[ 9707.596932]  i2c_transfer_buffer_flags+0x4c/0x70
[ 9707.596937]  i2c_hid_irq+0x3c/0x130 [i2c_hid]
[ 9707.596941]  irq_thread_fn+0x1f/0x50
[ 9707.596944]  irq_thread+0xf7/0x1a0
[ 9707.596946]  ? irq_thread_check_affinity.part.3+0xa0/0xa0
[ 9707.596949]  ? irq_thread_dtor+0xb0/0xb0
[ 9707.596953]  kthread+0x112/0x130
[ 9707.596956]  ? kthread_park+0x80/0x80
[ 9707.596959]  ret_from_fork+0x22/0x40
