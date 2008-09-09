From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2.6.27-rc4][RESEND] irq: irq and pci_ids patch for Intel Ibex Peak DeviceIDs
Date: Tue, 9 Sep 2008 11:44:34 -0700
Message-ID: <200809091144.35020.jbarnes@virtuousgeek.org>
References: <200808281540.59657.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756882AbYIISov@vger.kernel.org>
In-Reply-To: <200808281540.59657.seth.heasley@intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, khali@linux-fr.org
List-Id: linux-i2c@vger.kernel.org

On Thursday, August 28, 2008 3:40 pm Seth Heasley wrote:
> This patch updates the Intel Ibex Peak (PCH) LPC and SMBus Controller
> DeviceIDs.
>
> The LPC Controller ID is set by Firmware within the range of 0x3b00-3b1f. 
> This range is included in pci_ids.h using min and max values, and irq.c now
> has code to handle the range (in lieu of 32 additions to a SWITCH
> statement).
>
> The SMBus Controller ID is a fixed-value and will not change.
>
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>

Thanks for fixing this up, Seth.  I just applied it to my linux-next branch.

Jesse
