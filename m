From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mfd: i2c: convert SCx200 driver from using raw PCI to
 platform device
Date: Tue, 11 Jan 2011 11:47:46 +0100
Message-ID: <20110111104745.GC6616@sortiz-mobl>
References: <20101230202733.2f01b62d@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101230202733.2f01b62d@queued.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: Jim Cromie <jim.cromie@gmail.com>, khali@linux-fr.org, ben-linux@fluff.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-i2c@vger.kernel.org

Hi Andres,

On Thu, Dec 30, 2010 at 08:27:33PM -0800, Andres Salomon wrote:
> Note: this relies on the cs5535-mfd patches that are currently in the
> MFD next tree.  It's been tested on CS5536 hardware, but I don't have
> access to any old SCx200 hardware to verify that I didn't break the ISA
> stuff.
> 
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
