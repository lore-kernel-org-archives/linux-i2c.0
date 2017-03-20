From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] i2c: do not leave semaphore armed when copying
 properties fails
Date: Mon, 20 Mar 2017 10:06:33 -0700
Message-ID: <20170320170633.GA23083@dtor-ws>
References: <20170308184102.29334-1-dmitry.torokhov@gmail.com>
 <20170309144833.3mehuovi3wwqma2m@ninjato>
 <20170309173828.GA20077@dtor-ws>
 <20170309231653.GB4300@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170309231653.GB4300@tetsubishi>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, Mar 10, 2017 at 12:16:53AM +0100, Wolfram Sang wrote:
> 
> > I am perfectly fine with reverting b0c1e95ab44f from for-current,
> > however I wonder if we could have an immutable branch off 4.11-rc2 (or
> 
> Yes, sure. Please prepare a branch and once I reviewed all patches
> touching i2c core, we can (from my side at least) declare it immutable
> and I will pull it into i2c. I'll try to review the resources patch this
> weekend.
> 

Did you have a chance at looking the I2C IRQ resources patch? I prepared
a branch containing the 3 patches:

$ git log --oneline --reverse v4.11-rc3..HEAD
51f19be7f637 i2c: export i2c_client_type structure
5b57e4dd278e i2c: copy device properties when using i2c_register_board_info()
7f4bf035cb84 i2c: allow attaching IRQ resources to i2c_board_info

You can find it at:

git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
4.11-rc3-i2c-irq-resources

or:

https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/log/?h=4.11-rc3-i2c-irq-resources

If you are happy with the branch I'll add your acked-bys and mark it as
immutable so we can share it between our trees.

Thanks!

-- 
Dmitry
