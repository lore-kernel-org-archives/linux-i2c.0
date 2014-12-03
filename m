From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/2] Documentation: i2c: Use PM ops instead of legacy
 suspend/resume
Date: Wed, 3 Dec 2014 17:00:22 -0500
Message-ID: <20141203170022.6ec17a33@lwn.net>
References: <1417366352-22356-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1417366352-22356-1-git-send-email-lars@metafoo.de>
Sender: linux-doc-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 30 Nov 2014 17:52:31 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> New drivers should use PM ops instead of the legacy suspend/resume
> callbacks. Update the I2C device driver guides to reflect this.

It looks like nobody has picked this up; I'll take it through the docs
tree, I guess, unless somebody objects...

jon
