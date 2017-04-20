From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 09/38] Annotate hardware config module parameters in
 drivers/i2c/
Date: Thu, 20 Apr 2017 09:31:37 +0200
Message-ID: <20170420093137.5d28916d@endymion>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
        <149141148368.29162.12692004178864468110.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49667 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S944200AbdDTJxC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 20 Apr 2017 05:53:02 -0400
In-Reply-To: <149141148368.29162.12692004178864468110.stgit@warthog.procyon.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Wolfram Sang <wsa@the-dreams.de>, gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-i2c@vger.kernel.org

On Wed, 05 Apr 2017 17:58:03 +0100, David Howells wrote:
> When the kernel is running in secure boot mode, we lock down the kernel to
> prevent userspace from modifying the running kernel image.  Whilst this
> includes prohibiting access to things like /dev/mem, it must also prevent
> access by means of configuring driver modules in such a way as to cause a
> device to access or modify the kernel image.
> 
> To this end, annotate module_param* statements that refer to hardware
> configuration and indicate for future reference what type of parameter they
> specify.  The parameter parser in the core sees this information and can
> skip such parameters with an error message if the kernel is locked down.
> The module initialisation then runs as normal, but just sees whatever the
> default values for those parameters is.
> 
> Note that we do still need to do the module initialisation because some
> drivers have viable defaults set in case parameters aren't specified and
> some drivers support automatic configuration (e.g. PNP or PCI) in addition
> to manually coded parameters.
> 
> This patch annotates drivers in drivers/i2c/.
> 
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Wolfram Sang <wsa@the-dreams.de>
> cc: Jean Delvare <jdelvare@suse.com>
> cc: linux-i2c@vger.kernel.org
> (...)

Acked-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
