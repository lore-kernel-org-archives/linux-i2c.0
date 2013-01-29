From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 29 Jan 2013 15:29:23 +0100
Message-ID: <20130129152923.753b22de@endymion.delvare>
References: <20121218150337.5b861ae3@endymion.delvare>
	<1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359402232-21369-1-git-send-email-nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Oh, I forgot... checkpatch has the following to say:

WARNING: line over 80 characters
#699: FILE: drivers/i2c/busses/i2c-ismt.c:501:
+			dev_err(dev, "Error in mapping dma buffer %p\n", priv->dma_buffer);

ERROR: trailing whitespace
#725: FILE: drivers/i2c/busses/i2c-ismt.c:527:
+^I} $

WARNING: line over 80 characters
#1044: FILE: drivers/i2c/busses/i2c-ismt.c:846:
+		    (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)) != 0)) {

total: 1 errors, 2 warnings, 991 lines checked

Please fix these before resubmitting.

Thanks,
-- 
Jean Delvare
