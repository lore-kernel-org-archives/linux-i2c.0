From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] use devicemodel with parport
Date: Mon, 1 Jun 2015 07:05:30 +0900
Message-ID: <20150531220530.GF13872@kroah.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Tim Waugh <tim@cyberelk.net>, Willy Tarreau <willy@meta-x.org>, Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 20, 2015 at 08:56:56PM +0530, Sudip Mukherjee wrote:
> After 5 versions of WIP, finally a patch submission.
> parport subsystem is now in the transition stage and supports the old
> model and the new device model. 3 of the drivers have been converted
> into new model and tested.
> After other drivers are converted we can remove the old code from
> parport.

This looks good, very nice job.

Are you going to continue to fix up the other drivers?  I don't want us
to have a half-converted subsystem in the kernel.

thanks,

greg k-h
