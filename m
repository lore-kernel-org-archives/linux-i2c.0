From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-piix4: Add support for AMD ML and CZ SMBus  
 changes
Date: Tue, 28 Jan 2014 10:35:42 +0100
Message-ID: <20140128103542.5e0ba473@endymion.delvare>
References: <1390428346-2235-1-git-send-email-shane.huang@amd.com>
	<20140123132740.122c0f8a@endymion.delvare>
	<43EB3AB3EEFE8D43B525F4D2EAF507E1090ADBB0@SCYBEXDAG01.amd.com>
	<20140124084717.74da09ff@endymion.delvare>
	<43EB3AB3EEFE8D43B525F4D2EAF507E1090B0F04@SCYBEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E1090B0F04-7mPiUsE5EJ+PLz/DIDN4AEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Huang, Shane" <Shane.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Peng, Carl" <Carl.Peng-5C7GfCeVMHo@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 27 Jan 2014 19:38:09 +0000, Huang, Shane wrote:
> Hi Jean,
> 
> > > > BTW it would be really great if we could have access to the
> > > > documentation for these new AMD chipsets. I looked for both Hudson and
> > > > FCH at http://developer.amd.com/ but these searches returned nothing. I
> > > > could help better if I had access to the documentation / datasheets.
> > > 
> > > I don't know who is the website maintainer but forwarded your question
> > > to our FCH datasheet maintainer, and he will follow up. I hope that it will
> > > be improved in near future. :-)
> > 
> > Thanks!
> 
> AMD Kabini integrated FCH data sheet can be found in the BKDG (page 611),
> which is almost same as Hudson-2. The data sheet of ML is not released.
> 
> http://developer.amd.com/wordpress/media/2012/10/48751_BKDG_Fam_16h_Mod_00h-0Fh.pdf

Thanks Shane, this is very useful. I had not realized that the SMBus
controller was now part of the CPU itself.

-- 
Jean Delvare
