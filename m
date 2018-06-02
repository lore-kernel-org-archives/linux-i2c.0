From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
Date: Sat, 2 Jun 2018 15:16:14 +0200
Message-ID: <20180602131614.GD31493@kroah.com>
References: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: stable-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

On Tue, May 29, 2018 at 02:33:10PM +0100, Fabrizio Castro wrote:
> Hello Greg,
> 
> this series fixes an issue with the I2C driver of the Renesas R-Car and
> RZ/G1 family of chips. The issue is clearly visible with the CIP kernel
> (4.4) running on a iwg20d board from iWave due to the way the bq32000
> driver/device is interacting with the I2C driver/controller.
> In the stable kernel (4.4) there is no support for the iwg20d, I tried
> to replicate the same problem on a Koelsch board with no success, but
> the problem is there.
> 
> Do you think this series is suitable for (4.4) stable considering I
> can't reproduce the problem on the Koelsch board?

It looks good, all now queued up.

greg k-h
