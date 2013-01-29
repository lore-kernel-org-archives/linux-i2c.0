From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 29 Jan 2013 19:52:54 +0100
Message-ID: <20130129195254.64a26eec@endymion.delvare>
References: <20121218150337.5b861ae3@endymion.delvare>
	<1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
	<20130129150551.498b2a9b@endymion.delvare>
	<DEC3922D1904474A8862C7BFF516EA9A59B47EB2@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DEC3922D1904474A8862C7BFF516EA9A59B47EB2-P5GAC/sN6hmkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Bill E" <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 29 Jan 2013 16:57:16 +0000, Heasley, Seth wrote:
> Hi Jean,
> 
> >BTW, when I asked Bill several months ago for a datasheet for this part, he told
> >me it wasn't available publicly yet. Has the situation changed meanwhile?
> >There is an issue with SMBus block reads, as you'll see below. Without a
> >datasheet I can't verify how it can be solved, so you'll have to do it.
> 
> The datasheet is now publicly available:
> 
> http://www.intel.com/content/www/us/en/processors/atom/atom-processor-s1200-datasheet-vol-1.html
> http://www.intel.com/content/www/us/en/processors/atom/atom-processor-s1200-datasheet-vol-2.html
> http://www.intel.com/content/www/us/en/processors/atom/atom-processor-s1200-spec-update.html

Excellent, thanks Seth!

-- 
Jean Delvare
