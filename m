From: "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/3] MFD: introduce lpc_sch for Intel SCH LPC bridge
Date: Tue, 16 Feb 2010 05:59:34 -0800
Message-ID: <43F901BD926A4E43B106BF17856F0755A2D58DB5@orsmsx508.amr.corp.intel.com>
References: <4B73DAEE.5080400@compulab.co.il>
 <4B73DB4B.40501@compulab.co.il> <20100216100809.GA2935@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100216100809.GA2935-jcdQHdrhKHMdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


>
>On Thu, Feb 11, 2010 at 12:26:19PM +0200, Denis Turischev wrote:
>> Intel Poulsbo (SCH) chipset LPC bridge controller contains several
>> functions. Creating and MFD driver for the LPC bridge controller allows
>> simultaneous use of SMBus and GPIO interfaces on the SCH.
>That looks like an nice patch to me. Before merging it, I'd like to get
>Jacob's view on it though. Jacob, does moving the SCH SMBus driver to a
>platform one look fine to you ?
>
[[JPAN]] i agree with merging gpio and smbus into lpc driver. the only question
i had was whether impact to the user space tools has been considered. iirc,
there are sensors detect tools probe pci bus for smbus controllers, not sure it
does that for platform bus.
