From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Don't probe for slaves on IDF channels
Date: Tue, 10 May 2011 16:45:02 +0200
Message-ID: <20110510164502.3b0d5480@endymion.delvare>
References: <20110510160835.37bea352@endymion.delvare>
	<4DC94EB2.6020007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DC94EB2.6020007-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 10 May 2011 16:41:54 +0200, Hans de Goede wrote:
> Hi,
> 
> On 05/10/2011 04:08 PM, Jean Delvare wrote:
> > I don't know if Fujitsu is ever going to produce Patsburg-based
> > machines, but if they do, I'd rather not probe the secondary (IDF)
> > SMBus channels. At least not until we have a good reason for doing so.
> >
> > On a side note, I'm not even sure if it is right to enable detection
> > of HWMON and DDC devices on the IDF channels. Time will tell...
> >
> > Signed-off-by: Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Hans de Goede<hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > CC: David Woodhouse<David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> > Hans, David, what do you think?
> 
> Not probing for the FSC devices on the idf channel sounds reasonable
> to me. Note that Fujitsu has moved to using super io chips for hwmon
> now instead of their own i2c solutions, so for newer motherboards
> there aren't any of these i2c chips present at all.

Good to know, thanks for the info. Good move I'd say, it should be less
work for us to support their boards. 

-- 
Jean Delvare
