From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] i2c: jz4780: drop superfluous init
Date: Tue, 7 Jun 2016 14:47:04 +0800
Message-ID: <CAFRkauDYP6QgjbAFkx+aVrDQORhM3-pPNCdDEVELhFsQDZ4+aQ@mail.gmail.com>
References: <1465119702-4417-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34951 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbcFGGrF (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 7 Jun 2016 02:47:05 -0400
Received: by mail-lf0-f41.google.com with SMTP id u74so1500153lff.2
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jun 2016 23:47:05 -0700 (PDT)
In-Reply-To: <1465119702-4417-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, David Binderman <dcb314@hotmail.com>

2016-06-05 17:41 GMT+08:00 Wolfram Sang <wsa@the-dreams.de>:
> David reported that the length for memset was incorrect (element sizes
> were not taken into account). Then I saw that we are clearing kzalloced
> memory, so we can simply drop this code.
>
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
