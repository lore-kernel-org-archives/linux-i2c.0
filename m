From: Tarker Hu <tarkerhu@gmail.com>
Subject: 2 Questions about "i2c-tools (3.1.1)"
Date: Tue, 15 Aug 2017 17:42:55 +0800
Message-ID: <CAFz8etO28fsVkYkcw8ZxAX2sh69B+EHS8oL08tjBpWbwTew3Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36396 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbdHOJm4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Aug 2017 05:42:56 -0400
Received: by mail-qt0-f178.google.com with SMTP id v29so1862559qtv.3
        for <linux-i2c@vger.kernel.org>; Tue, 15 Aug 2017 02:42:56 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi,



=E3=80=80=E3=80=80We are using "i2c-tools (3.1.1)" and we have 2 questions:

=E3=80=80=E3=80=80(01 ) When I send cmd =E2=80=9Ci2cdetect -y -r 2=E2=80=9D=
, I find that some device
address always shows =E2=80=9CUU=E2=80=9D.

        What =E2=80=9CUU=E2=80=9D means?

=E3=80=80=E3=80=80=E3=80=80=E3=80=80When I used i2cdump to that address (sh=
owing =E2=80=9CUU=E2=80=9D), it always came
out =E2=80=9CXXXX=E2=80=9D. Can I i2cdump it?

=E3=80=80=E3=80=80=E3=80=80=E3=80=80Is there any document about that?



=E3=80=80=E3=80=80(02 ) If I need to i2cget/i2cset to an device with =E2=80=
=9Cword-address
(address with 16 bits)=E2=80=9D, how can I do?

=E3=80=80=E3=80=80=E3=80=80=E3=80=80Is there any document?

=E3=80=80=E3=80=80=E3=80=80=E3=80=80Can you show me a real example?



Best,

Tarker
