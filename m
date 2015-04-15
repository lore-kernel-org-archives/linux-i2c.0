From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 15:23:50 +0200
Message-ID: <20150415132350.GF21491@kroah.com>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, dan.carpenter@oracle.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 15, 2015 at 01:18:41PM +0530, Sudip Mukherjee wrote:
> --- a/drivers/parport/share.c
> +++ b/drivers/parport/share.c
> @@ -10,6 +10,8 @@
>   * based on work by Grant Guenther <grant@torque.net>
>   *          and Philip Blundell
>   *
> + * Added Device-Model - Sudip Mukherjee <sudip@vectorindia.org>

Changelog handles this, no need to add it to the file.

