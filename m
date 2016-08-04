From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH] i2c: ocores: add missed clk_disable_unprepare() on failure paths
Date: Thu, 04 Aug 2016 20:45:23 +0200
Message-ID: <87wpjwfk58.fsf@dell.be.48ers.dk>
References: <1470267524-14753-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470267524-14753-1-git-send-email-khoroshilov@ispras.ru> (Alexey
	Khoroshilov's message of "Thu, 4 Aug 2016 02:38:44 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Alexey" == Alexey Khoroshilov <khoroshilov@ispras.ru> writes:

 > clk_disable_unprepare() is missed on failure paths in ocores_i2c_probe().
 > Found by Linux Driver Verification project (linuxtesting.org).

 > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
