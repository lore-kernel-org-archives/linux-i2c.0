From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c-mv64xxx: use subsys_initcall for early
	initialization
Date: Wed, 15 Sep 2010 14:49:56 +0100
Message-ID: <20100915134956.GB21620@sirena.org.uk>
References: <1284284129-28105-1-git-send-email-mike@compulab.co.il> <20100914232547.GD7494@trinity.fluff.org> <4C90CD6C.60100@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C90CD6C.60100-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 15, 2010 at 03:43:08PM +0200, Mike Rapoport wrote:
> Ben Dooks wrote:

>>>  drivers/i2c/busses/i2c-mv64xxx.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)

>> We really should have an i2c_initcall, but it may be difficult to move
>> everyone over to it. What would be lovely is some form of dependency
>> based initialisation, but that's probably a way off...

> Yeah, that would be nice...

Grant Likely was muttering about contributing something here.
