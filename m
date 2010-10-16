From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2.6.35.4] irq: irq and pci_ids patch for Intel Patsburg
Date: Sat, 16 Oct 2010 08:40:18 +0200
Message-ID: <20101016084018.58671452@endymion.delvare>
References: <201009241606.11840.seth.heasley@intel.com>
	<201010041327.15170.seth.heasley@intel.com>
	<20101015125428.01120a8d@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20101015125428.01120a8d@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Seth Heasley <seth.heasley@intel.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 15 Oct 2010 12:54:28 -0700, Jesse Barnes wrote:
> On Mon, 4 Oct 2010 13:27:14 -0700
> Seth Heasley <seth.heasley@intel.com> wrote:
> > This patch updates the defines for Intel devices in include/linux/pci_ids.h, referenced in arch/x86/pci/irq.c and drivers/i2c/busses/i2c-i801.c, reflecting approved legal branding, and using fuller code-names for products under development.
> >  
> > Signed-off-by: Seth Heasley <seth.heasley@intel.com>
> 
> Applied this update, thanks.
> 
> Note that going forward I don't expect (or want!) patches to convert
> the development names into marketing names.  We should just add new
> stuff with the development names (before the product ships) and leave
> them that way to avoid unnecessary churn.

Fine with me, as long as it is the actual names and not obscure
3-letter shortcuts.

-- 
Jean Delvare
