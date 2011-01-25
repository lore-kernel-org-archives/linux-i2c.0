From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Identifying i2c devices on Asus P8P67 sandybridge motherboard
Date: Tue, 25 Jan 2011 17:42:46 +0100
Message-ID: <20110125174246.5061f881@endymion.delvare>
References: <4D3EF4C0.1090008@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D3EF4C0.1090008-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Phillip,

On Tue, 25 Jan 2011 11:05:20 -0500, Phillip Susi wrote:
> I recently got a new Asus P8P67 Pro motherboard with a sandybridge core
> i5 2500K.  After checking the Intel chipset docs, I found that it has an
> i2c controller and it was enumerated on the pci bus, but no driver was
> loaded for it.  I found the i2c-i801 module and the comments in the
> source say it supports the Cougar Point (PCH) and matches the PCI ID.
> I'm not sure why it wasn't auto loaded, but after loading it, it seemed
> to work.

Probably because you run a distribution where someone stupidly
blacklisted i2c-i801 because it caused trouble on one single machine
once. And you should report this as a bug.

> At that point I ran sensors-detect, which failed to recognize any known
> controllers on the bus, but i2c-detect found several addresses that
> responded.  How can I proceed with identifying what these devices are,
> so that I can hopefully find or write a driver to communicate with them?

All recent desktop boards from Asus implement an ACPI device named
ATK0110 for hardware monitoring, which is supported by the asus_atk0110
driver. So if all you are interested in is hardware monitoring, that's
the way to go.

If you really want a complete analysis of what may be on your SMBus,
please share the output of i2cdetect with us. You can get register
dumps from most devices using i2cdump, however I would NOT recommend
doing this on all addresses randomly, as some devices are known to
misbehave when accessed in a way they do not expect.

-- 
Jean Delvare
