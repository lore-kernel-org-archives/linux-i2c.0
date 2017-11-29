From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] lib: Fix compilation when USE_STATIC_LIB
Date: Wed, 29 Nov 2017 11:08:08 +0100
Message-ID: <20171129110808.4168f82f@endymion>
References: <1511909897-18600-1-git-send-email-angelo@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45553 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754078AbdK2KIL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Nov 2017 05:08:11 -0500
In-Reply-To: <1511909897-18600-1-git-send-email-angelo@amarulasolutions.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Angelo Compagnucci <angelo@amarulasolutions.com>
Cc: linux-i2c@vger.kernel.org

Hi Angelo,

On Tue, 28 Nov 2017 23:58:17 +0100, Angelo Compagnucci wrote:
> This patch removes the mandatory compiling of the shared library
> when USE_STATIC_LIB is used.

No, thanks. The current behavior is as desired: always build the
dynamic library, and optionally build the static library. It was never
the intent to allow only building the static library. Static libraries
are evil.

-- 
Jean Delvare
SUSE L3 Support
