From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v2 1/2] i2c: octeon: thunderx: Check bus state before
 starting a transaction
Date: Mon, 26 Sep 2016 07:58:46 +0200
Message-ID: <20160926055745.GA3134@hardcore>
References: <cover.1474565039.git.jglauber@cavium.com>
 <ccf553c14d5220f3f9233ac7695d27ee0d55bcc7.1474565039.git.jglauber@cavium.com>
 <20160924092418.GG1434@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160924092418.GG1434@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
List-Id: linux-i2c@vger.kernel.org

On Sat, Sep 24, 2016 at 11:24:19AM +0200, Wolfram Sang wrote:
> On Fri, Sep 23, 2016 at 11:40:38AM +0200, Jan Glauber wrote:
> > Add an additional status check before starting a transaction. If the
> > check fails wait for some time to tolerate multi-master mode. After the
> > timeout expires trigger the recovery.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> Need to think more about it, needs to wait for next cycle.
> 

OK, please share your thoughts when you get to it.

--Jan
