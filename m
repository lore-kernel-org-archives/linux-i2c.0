From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 5 Feb 2013 17:41:36 +0100
Message-ID: <20130205174136.070ab42c@endymion.delvare>
References: <1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
	<1360007650-26272-1-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360007650-26272-1-git-send-email-nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon,  4 Feb 2013 14:54:10 -0500, Neil Horman wrote:
> The iSMT (Intel SMBus Message Transport) supports multi-master I2C/SMBus,
> as well as IPMI.  It's operation is DMA-based and utilizes descriptors to
> initiate transactions on the bus.
> 
> The iSMT hardware can act as both a master and a target, although this
> driver only supports being a master.
> 
> Signed-off-by: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
> Signed-off-by: Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Tested-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> CC: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> CC: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> (...)

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
