From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] Fix double address byte issue
Date: Sat, 2 Jun 2018 15:17:26 +0200
Message-ID: <20180602131726.GE31493@kroah.com>
References: <1527674833-13122-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527674833-13122-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: stable-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 30, 2018 at 11:07:10AM +0100, Fabrizio Castro wrote:
> Hello Greg,
> 
> Wolfram recommends the backporting of this series in order to
> improve the situation with a race condition.
> Do you think you can take this series for 4.4 stable?
> 
> This series applies on 4.4.133, and depends on series:
> "Fix R-Car I2C data byte sent twice issue"

All now queued up, thanks.

greg k-h
