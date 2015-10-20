From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] i2c: i2c-au1550: relax bus timings a bit
Date: Tue, 20 Oct 2015 19:54:07 +0200
Message-ID: <CAOLZvyGWqTvxOJ=h0U8eN8wLzReDMEjYvD0nbdCx7vFFLTovmg@mail.gmail.com>
References: <1441695383-87868-1-git-send-email-manuel.lauss@gmail.com> <20151020154443.GK5379@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37277 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbJTRys (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Oct 2015 13:54:48 -0400
Received: by wicfv8 with SMTP id fv8so40694360wic.0
        for <linux-i2c@vger.kernel.org>; Tue, 20 Oct 2015 10:54:47 -0700 (PDT)
In-Reply-To: <20151020154443.GK5379@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux-I2C <linux-i2c@vger.kernel.org>

On Tue, Oct 20, 2015 at 5:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Since you have access to these platforms, there is a pending devm
> conversion patchneeding some testing:
>
> http://patchwork.ozlabs.org/patch/482140/
>
> Are you maybe interested in checking that one?

Sure,  I've run-tested it now on the DB1300 board, no problems.
Tested-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks!
        Manuel
