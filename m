From: Ioan Nicu <ioan.nicu.ext@nokia.com>
Subject: Re: [PATCH] i2c: i2c-mux-gpio: Change log level to debug for probe
 deferrals
Date: Mon, 30 Mar 2015 09:57:05 +0200
Message-ID: <20150330075652.GA31778@ulegcpding.emea.nsn-net.net>
References: <20150325174351.GB5209@ulegcpding.emea.nsn-net.net>
 <20150327152932.GB27238@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150327152932.GB27238@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Wolfram Sang <wsa@the-dreams.de>
Cc: Ioan Nicu <ioan.nicu.ext@nsn.com>, Peter Korsgaard <peter.korsgaard@barco.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Mathias Rulf <mathias.rulf@nokia.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 27, 2015 at 04:29:33PM +0100, ext Wolfram Sang wrote:
> On Wed, Mar 25, 2015 at 06:43:51PM +0100, Ioan Nicu wrote:
> > Probe deferral is not an error case. It happens only when
> > the necessary dependencies are not there yet.
> > 
> > The driver core is already printing a message when a driver
> > requests probe deferral, so this can be traced in the logs
> > without these error prints.
> > 
> > This patch changes the error messages from these deferral cases
> > to debug messages.
> > 
> > Signed-off-by: Ionut Nicu <ioan.nicu.ext@nokia.com>
> 
> Why not simply removing it?
> 

Right, those messages are not relevant anyway, so removing them is better.
I'll send out an updated patch.

Thanks!
