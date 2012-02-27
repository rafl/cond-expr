use strict;
use warnings;

package Cond::Expr;

use Sub::Exporter -setup => {
    exports => ['cond'],
    groups  => { default => ['cond'] },
};

use Devel::CallParser;
use Devel::CallChecker;

use XSLoader;

XSLoader::load(__PACKAGE__);

1;
