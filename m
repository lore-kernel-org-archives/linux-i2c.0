From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: driver-api: i2c: remove some outdated information
Date: Mon, 5 Jun 2017 15:59:54 -0600
Message-ID: <20170605155954.0ee0c306@lwn.net>
References: <20170523134654.11892-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523134654.11892-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 23 May 2017 15:46:54 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> a) Linux can be an I2C slave meanwhile
> b) all drivers except one use the driver model currently
> 
> Update the documentation.

I wasn't sure if you wanted me to apply this one or not...I don't see it
in linux-next, so I've gone ahead and done so.

Thanks,

jon
