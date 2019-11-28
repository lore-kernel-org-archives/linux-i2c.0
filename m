From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
Date: Thu, 28 Nov 2019 14:44:56 +0100
Message-ID: <CACRpkdYEEypRZOaO3Ta9aDgizNeLyUOSraBEhKaZcHaJV+o0gQ@mail.gmail.com>
References: <20191120142038.30746-1-ktouil@baylibre.com> <20191120142038.30746-2-ktouil@baylibre.com>
 <CACRpkdaZrvPObjyN4kasARzKZ9=PiAcvTzXzWkmC7R+Ay5tU8w@mail.gmail.com>
 <CAMpxmJWSgYjcGdR7Zrj-=nA+H8cYfZUriHQPxN=8zgPDvD-wTA@mail.gmail.com>
 <CACRpkdaW82pgQivc0VVgqqVv4fgXxMyGD3Lo8YHcMK7aGPDKaw@mail.gmail.com>
 <CAMpxmJU_0MzroyD_ZF5WOxpZz3dkADLOmW7aKpWdJ7GCvo-RnA@mail.gmail.com>
 <CACRpkdaPQKxfC66yhG=xdmCOGGd9PjDVCwZquKb+4HmuS_=kNA@mail.gmail.com> <CALL1Z1xpcGyh_f3ooRT+gGApoAnS7YBMd2hUKqnt+pTcAFoeAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALL1Z1xpcGyh_f3ooRT+gGApoAnS7YBMd2hUKqnt+pTcAFoeAg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 26, 2019 at 4:18 PM Khouloud Touil <ktouil@baylibre.com> wrote:

> [Me]
>> 4. The code still need to be modified to set the value
>>    to "1" to assert the line since the gpiolib now handles
>>    the inversion semantics.

> By saying "assert the wp" do you mean enable the write operation or
> block it ?

Yeah one more layer of confusion, sorry :/

By "asserting WP" I mean driving the line to a state where
writing to the EEPROM is enabled, i.e. the default state is
that the EEPROM is write protected and when you "assert"
WP it becomes writable.

If you feel the inverse semantics are more intuitive (such that
WP comes up asserted and thus write protected), be my
guest :D

As long as it is unambiguously documented in the bindings
and with comments in the code I'm game for whatever the
at24 people feel is most appropriate. (You will set the standard
for everyone else.)

Yours.
Linus Walleij
