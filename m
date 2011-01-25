From: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Identifying i2c devices on Asus P8P67 sandybridge motherboard
Date: Tue, 25 Jan 2011 11:05:20 -0500
Message-ID: <4D3EF4C0.1090008@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I recently got a new Asus P8P67 Pro motherboard with a sandybridge core
i5 2500K.  After checking the Intel chipset docs, I found that it has an
i2c controller and it was enumerated on the pci bus, but no driver was
loaded for it.  I found the i2c-i801 module and the comments in the
source say it supports the Cougar Point (PCH) and matches the PCI ID.
I'm not sure why it wasn't auto loaded, but after loading it, it seemed
to work.

At that point I ran sensors-detect, which failed to recognize any known
controllers on the bus, but i2c-detect found several addresses that
responded.  How can I proceed with identifying what these devices are,
so that I can hopefully find or write a driver to communicate with them?
