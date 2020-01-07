From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 04/12] i2c: ocores: convert to use i2c_new_client_device()
Date: Tue, 7 Jan 2020 20:36:47 +0100
Message-ID: <20200107193647.GA16895@lunn.ch>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
 <20200107174748.9616-5-wsa+renesas@sang-engineering.com>
 <87muazjewd.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87muazjewd.fsf@dell.be.48ers.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 07, 2020 at 07:32:50PM +0100, Peter Korsgaard wrote:
> >>>>> "Wolfram" == Wolfram Sang <wsa+renesas@sang-engineering.com> writes:
> 
>  > Move away from the deprecated API and return the shiny new ERRPTR where
>  > useful.
> 
>  > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> I didn't follow the discussion, but I don't see any returns anywhere?

Hi Peter

I have also not been following the discussion. But i2c_new_device()
seems to of always returned a NULL pointer on error, and the code has
been ignoring it. The 'where useful' comment suggests the return value
maybe checked, but it is optional to check it.  So this patch seems
O.K.

I suppose the commit message could be extended with:

In this case, the shiny new stuff is not useful, so ignore it.

But:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
