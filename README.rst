====
git2chlog
====

|nimble-version| |nimble-install| |gh-actions|

git2chlog generates changelog from git-log.

.. contents:: Table of contents

Usage
=====

.. code-block:: shell

   $ git2chlog deb
   websh (v2.2.2) unstable; urgency=low

     * (GitHub) Merge pull request #179 from jiro4989/hotfix/#178-js
     * (jiro4989) 使わなくなったステージを削除 #178
     * (jiro4989) Javascriptのビルドをホストに保存できていなかったのを修正 #178
     * (jiro4989) service起動設定の修正が必要な旨を追記 [skip ci]
     * (jiro4989) 誤字を修正 [skip ci]
     * (jiro4989) 説明を修正 [skip ci]

    -- jiro4989 <jiroron666@gmail.com> Sun, 5 Jul 2020 11:01:34 +0900

Installation
============

.. code-block:: shell

   $ nimble install -Y https://github.com/jiro4989/git2chlog

or

Downloads from `Releases <https://github.com/jiro4989/git2chlog/releases>`_.

LICENSE
=======

MIT

.. |gh-actions| image:: https://github.com/jiro4989/git2chlog/workflows/build/badge.svg
   :target: https://github.com/jiro4989/git2chlog/actions
.. |nimble-version| image:: https://nimble.directory/ci/badges/git2chlog/version.svg
   :target: https://nimble.directory/ci/badges/git2chlog/nimdevel/output.html
.. |nimble-install| image:: https://nimble.directory/ci/badges/git2chlog/nimdevel/status.svg
   :target: https://nimble.directory/ci/badges/git2chlog/nimdevel/output.html
