From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 0/2] i2c: ismt: Fix length handling for SMBus block reads
Date: Tue, 29 Aug 2017 07:35:58 -0400
Message-ID: <20170829113558.GA5406@hmswarspite.think-freely.org>
References: <1502140260-13789-1-git-send-email-stephend@adiengineering.com>
 <20170814193105.cosdlbf5gypazlzn@ninjato>
 <f1d1d452-892a-82ff-c6a2-1e2512d9ed70@adiengineering.com>
 <20170829102225.7yjh52hivygbdbc7@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170829102225.7yjh52hivygbdbc7@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Stephen Douthit <stephend@adiengineering.com>, seth.heasley@intel.com, danp@adiengineering.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 29, 2017 at 12:22:25PM +0200, Wolfram Sang wrote:
> 
> > >> So basically the byte count already precedes the data in the dma_buffer,
> > >> then the driver sticks desc->rxbytes in front of this resulting in the
> > >> trace above.
> > >>
> > >> The first patch tackles this.
> > >>
> > >> The second patch in the series adds a sanity check on the byte count
> > >> supplied by the slave device.  This might be a nice to have, but is
> > >> probably less critical.
> > > 
> > > Both patches look good to me. Seth, Neil, do you agree?
> > > 
> > 
> > Ping.
> > 
> > Not sure what the usual review time is, let me know if this is premature.
> 
> I applied both patches to for-next (v4.14) now to get a broader
> audience. for-current (v4.13) might have been also applicable, but I
> don't want to apply the patches there without the driver maintainer
> acks. I hope this works for you.
> 

Sorry, I've been on vacation, yes, the patches look good to me

Acked-by: Neil Horman <nhorman@tuxdriver.com>
