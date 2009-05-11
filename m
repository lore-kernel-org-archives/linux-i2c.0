From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH 2.6.29.2] PXA I2C: Define log level for i2c PXA error
	report
Date: Mon, 11 May 2009 13:23:19 +0100
Message-ID: <20090511122319.GB20283@sirena.org.uk>
References: <Pine.LNX.4.64.0905060829580.24668@venus.araneidae.co.uk> <20090506102202.73d6045d@hyperion.delvare> <Pine.LNX.4.64.0905081102060.14384@venus.araneidae.co.uk> <fd6b62c10905110311w6350828tf90d9c699b73fe30@mail.gmail.com> <Pine.LNX.4.64.0905111126020.20970@venus.araneidae.co.uk> <20090511112801.GA20283@sirena.org.uk> <Pine.LNX.4.64.0905111314450.30347@venus.araneidae.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0905111314450.30347-EMtNTEpPrk39UE2ag0LVtCp2UmYkHbXO@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Abbott <michael-W/Bzo8D1sxa8qtKVGud/9w@public.gmane.org>
Cc: ???? <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 11, 2009 at 01:16:38PM +0100, Michael Abbott wrote:

> However, then, does it make sense for the PXA i2c bus prober to be calling 
> the "scream blue murder" routine in this frankly routine case?  I guess it 
> could just say "no device found at address xx"

You should really convert your board to specify explicitly which chips
are on the board rather than using the old style probe routines.
