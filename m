From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Intel lynx point designware issue
Date: Mon, 2 Feb 2015 12:25:45 +0200
Message-ID: <20150202102545.GQ22740@lahna.fi.intel.com>
References: <195CACBC-7E0B-4598-986C-0814289C6ECD@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <195CACBC-7E0B-4598-986C-0814289C6ECD-ee4meeAH724@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Daoud <alex.daoud-ee4meeAH724@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 30, 2015 at 04:36:27PM +0000, Alexandre Daoud wrote:
> Hey Linux-i2c,
> 
> I have a bit of an unorthodox question for this mailing list but you guys seem like the only people who could help me at this point.
> 
> I have a Dell Venue 11 Pro tablet with the Lynxpoint I2C busses
> (INT33C2, INT33C3), one of which drives an i2c-hid touchscreen device.
> I have installed OS X on this device and I have been attempting to
> port the Linux designware i2c drivers to OS X. The drivers are pretty
> much just a carbon copy of the ones in the Linux kernel with obvious
> modifications to integrate with the Darwin kernel. The issue that I am
> facing is that no matter what I do, the I2C bus seems to refuse to
> start an I2C transaction. Here is the sequence of events:
> 
> I initiate a transaction on the bus with code exactly equivalent to
> that in i2c_dw_xfer_init. The bus then generates a IC_INTR_TX_EMPTY
> interrupt and I start filling the transaction fifo by writing to the
> data command register. The bus generates a few IC_INTR_TX_EMPTY to
> avoid overflow (again, this is following the structure of the Linux
> kernel drivers pretty much line by line). Once the data has been
> written (with a restart in the middle for direction change and a stop
> on the last entry), nothing happens. The data to be sent sits in the
> transaction fifo and the bus does not initiate the transaction, no
> matter what I try.

One thing that comes to mind is that some of the earlier Lynxpoint I2C
host controllers had the functional clock gated. If you check what is
done in drivers/acpi/acpi_lpss.c:

        if (dev_desc->flags & LPSS_CLK_GATE) {
                clk = clk_register_gate(NULL, devname, parent, 0,
                                        prv_base, 0, 0, NULL);
                parent = devname;
        }

You could try the same so that you set bit 0 in the private register
space (starting at 0x800).
