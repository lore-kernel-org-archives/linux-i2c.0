From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 2/3] i2c: octeon: Add retry logic after receiving
 STAT_RXADDR_NAK
Date: Tue, 14 Jun 2016 10:03:51 +0200
Message-ID: <20160614080351.GA4725@hardcore>
References: <cover.1465304877.git.jglauber@cavium.com>
 <2cc75a97f920146edc7af389870e271a8a056dd1.1465304877.git.jglauber@cavium.com>
 <20160609201150.GH23522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160609201150.GH23522@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 09, 2016 at 10:11:51PM +0200, Wolfram Sang wrote:
> On Wed, Jun 08, 2016 at 08:51:18AM +0200, Jan Glauber wrote:
> > The controller specification states that when receiving STAT_RXADDR_NAK
> > the START should be sent again. Retry several times before finally
> > failing with -ENXIO.
> > 
> > Without this change the IPMI SSIF driver fails executing several commands
> > like 'ipmitool fru' on ThunderX.
> 
> Huh? Looks wrong to me. I'd say the client driver needs to retry. Only
> that one knows if retrying is appropriate or a waste of time.
> 

I've been debugging this and it turned out that there was an related issue with
the clock setting. With that corrected this patch is not needed anymore,
so you can drop it.

I still see a huge number of RXADDR_NAK's after START but the ipmi_ssif
driver retry logic seems to deal with that.

thanks,
Jan
